# Zombie Process Killer

This script finds and kills zombie processes on Ubuntu systems. It sends the `SIGCHLD` signal to the parent process responsible for the zombie process, waits for up to 5 seconds for the zombie process to be reaped, and if the zombie process still exists, it forcibly kills the parent process using the `kill -9` command.

**Warning:** Use this script with caution. Investigate the zombie processes manually and understand the potential impact of forcibly killing the parent processes before using this script .

## Want to connect?

Feel free to contact me on [Twitter](https://twitter.com/OnlineAnto), [DEV Community](https://dev.to/antoonline/) or [LinkedIn](https://www.linkedin.com/in/anto-online) if you have any questions or suggestions.

Or just visit my [website](https://anto.online) to see what I do.
