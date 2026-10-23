"""Stateless comparison; outputs drive a separately named notification job."""

import hashlib
import io
import os
from pathlib import Path
import sys
from datetime import datetime
from urllib.request import Request, urlopen
import zipfile
from zoneinfo import ZoneInfo


URL = "https://zqjxkvby.com/permuzzle/permuzzle.jar"
ROOT = Path(__file__).resolve().parents[2]
MAX_BYTES = 32 * 1024 * 1024


def validate_jar(data):
    if not data:
        raise ValueError("Empty download")
    with zipfile.ZipFile(io.BytesIO(data)) as jar:
        if not any(name.endswith(".class") for name in jar.namelist()):
            raise ValueError("Archive contains no Java classes")
        if sum(item.file_size for item in jar.infolist()) > 128 * 1024 * 1024:
            raise ValueError("Uncompressed archive is unexpectedly large")
        bad_entry = jar.testzip()
        if bad_entry:
            raise ValueError(f"Corrupt JAR entry: {bad_entry}")


def main():
    now = datetime.now(ZoneInfo("America/Los_Angeles"))
    friday = now.weekday() == 4
    force = os.environ.get("FORCE_NOTIFICATION", "false").lower() == "true"
    baseline = (ROOT / "permuzzle/permuzzle.jar").read_bytes()
    validate_jar(baseline)
    try:
        request = Request(URL, headers={"User-Agent": "Permuzzle-update-monitor"})
        with urlopen(request, timeout=45) as response:
            remote = response.read(MAX_BYTES + 1)
        if len(remote) > MAX_BYTES:
            raise ValueError("Download exceeds 32 MiB limit")
        validate_jar(remote)
    except Exception as error:
        title = "INCONCLUSIVE: author's JAR could not be checked"
        details = f"Comparison skipped: {type(error).__name__}: {error}"
        notify = friday or force
    else:
        different = baseline != remote
        title = (
            "UPDATE: author's JAR differs from main; run update.bat"
            if different else "GREEN: monitor working; committed JAR is current"
        )
        details = (
            f"Committed SHA-256: {hashlib.sha256(baseline).hexdigest()}\n"
            f"Author SHA-256: {hashlib.sha256(remote).hexdigest()}"
        )
        notify = different or friday or force

    report = (
        f"{title}\n\nLos Angeles time: {now.isoformat()}\n"
        f"Manual test requested: {force}\n\n{details}\n\n"
        "A separate job intentionally fails to request a notification when a signal is due.\n"
        "No files are updated; downloads are held only in memory.\n"
    )
    print(report)
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as output:
            output.write(report)
    output_path = os.environ.get("GITHUB_OUTPUT")
    if output_path:
        with open(output_path, "a", encoding="utf-8") as output:
            output.write(f"title={title}\nnotify={str(notify).lower()}\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
