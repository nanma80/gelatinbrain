# Gelatinbrain Puzzle Simulator

**[Click here to download](https://github.com/Hypercubers/gelatinbrain/archive/refs/heads/main.zip)**

Everything you need to run the gelatinbrain puzzle simulator

This program is also known as:

- gelatinbrain's Virtual Magic Polyhedra
- permutation puzzle
- permuzzle
- jzzz

See also the [archived scoreboard](https://qjxkvbyz.000webhostapp.com/permuzzle/scoreboard.php)

## Usage

1. Clone this repository
2. Run `run.bat` (Windows) or `run.sh` (macOS/Linux)

## Update monitor

The `Permuzzle update monitor` GitHub Actions workflow checks the author's JAR
against `permuzzle/permuzzle.jar` on `main` daily at 22:00 UTC
(3 p.m. PDT / 2 p.m. PST). It never updates
the repository. Downloads stay in memory and are validated as Java archives.

Enable email notifications for Actions in your personal GitHub notification
settings, and select **Only notify for failed workflows**. Scheduled notifications
go to the user who creates the schedule, last edits its cron, or re-enables it.
No custom secrets or email credentials are required.

- Different JAR: intentional failure every day, requesting an update notification.
- Matching JAR: intentional failure on Fridays in America/Los_Angeles for a green
  heartbeat; silent success on other days.
- Failed, empty, or invalid author download: skip comparison; intentional failure
  on Fridays for an inconclusive signal, silent success on other days.
- Unexpected monitor errors also fail, so inspect the run summary/logs to distinguish
  a requested signal from a real workflow problem.

Emails use GitHub's failure wording even for healthy Friday signals, but the
failing job's name includes GREEN, UPDATE, or INCONCLUSIVE and the result.
The comparison job succeeds; a separate notification job deliberately fails
only when a signal is due. To test, select **Actions → Permuzzle update monitor
→ Run workflow**. On Friday every run sends a signal; on other days enable
`force_notification` to request one. Repeated runs can each produce a notification.

After receiving an update alert, run `update.bat` locally and commit/push the new
JAR to `main`; alerts stop when the files match. Public repository schedules are
disabled after 60 days without repository activity. Push a commit before then to
keep the schedule active, or use **Enable workflow** if it has been disabled.

## Caveats

- On macOS, the program crashes when loading a new puzzle while one is already open. To work around this, close the program; the script will automatically restart it if you had a puzzle open. To actually close the program, close it from the puzzle selection menu.
- On Linux, the program shows a blank white screen. If anyone knows how to fix this, let us know!

## Acknowledgements

- gelatinbrain, for originally developing the program
- the host of [qjxkvbyz.000webhostapp.com](https://qjxkvbyz.000webhostapp.com/permuzzle/), for providing a download link and installation instructions
- Luna and Hactar, for assembling this repository and its dependencies
