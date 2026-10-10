========================================================================

             SSH SECURITY LOG ANALYSIS USING LINUX TOOLS

========================================================================




1. OVERVIEW

------------------------------------------------------------------------

This project provides an automated Bash-based solution for analyzing SSH

authentication logs (`auth_security.log`) on a Linux system. It detects 

potential brute-force login attempts by parsing log telemetry, identifying 

repeated password failures per source IP address, and flagging suspicious 

IP addresses exceeding a predefined security threshold.





2. PROJECT STRUCTURE

------------------------------------------------------------------------

.

├── auth_security.log    # Raw target authentication log file

├── threat_detect.sh     # Bash automation script for log triage

├── cleaned_security.log # Output generated after whitespace normalization

└── README.txt           # Project documentation and user guide





3. PREREQUISITES & ENVIRONMENT

------------------------------------------------------------------------

- Operating System: Linux (e.g., Kali Linux, Ubuntu, Debian)

- Shell: GNU Bash (v4.0 or higher)

- Utilities Required: grep, sed, awk, sort, uniq





4. SETUP & EXECUTION PROCEDURES

------------------------------------------------------------------------

Step 1: Ensure all files (`threat_detect.sh` and `auth_security.log`) 

        are located in the same directory.



Step 2: Open your terminal and navigate to the working directory:

        $ cd /path/to/log-analysis



Step 3: Grant executable permissions to the script:

        $ chmod +x threat_detect.sh



Step 4: Run the analysis script:

        $ ./threat_detect.sh



Step 5: (Optional) Inspect the sanitized log output:

        $ cat cleaned_security.log





5. SCRIPT CONFIGURATION

------------------------------------------------------------------------

Inside `threat_detect.sh`, you can adjust the following parameters:



  LOG_FILE="auth_security.log"   # Path to the authentication log

  CLEANED_LOG="cleaned_security.log" # Output target for normalized data

  THRESHOLD=3                    # Failure threshold for flagging IPs





6. SAMPLE INPUT LOG FORMAT (`auth_security.log`)

------------------------------------------------------------------------

Sep 07 14:20:11 anshul-kali sshd[2101]: Failed password for invalid user admin from 10.0.2.45 port 51234 ssh2

Sep 07 14:20:15 anshul-kali sshd[2102]: Failed password for invalid user root from 10.0.2.45 port 51235 ssh2

Sep 07 14:20:19 anshul-kali sshd[2103]: Failed password for invalid user test from 10.0.2.45 port 51236 ssh2

Sep 07 14:20:23 anshul-kali sshd[2104]: Failed password for invalid user guest from 10.0.2.45 port 51237 ssh2

Sep 07 14:20:28 anshul-kali sshd[2105]: Failed password for invalid user admin from 10.0.2.45 port 51238 ssh2






7. SAMPLE SCRIPT OUTPUT

------------------------------------------------------------------------

=== SSH SECURITY LOG ANALYSIS ===



Total failed login attempts: 8

Total successful login attempts: 1



Failed login attempts grouped by IP address:

      2 10.0.2.18

      6 10.0.2.45



Suspicious IP addresses (Exceeding threshold of 3 failures):

10.0.2.45 - 6 failed attempts



=== ANALYSIS COMPLETE ===


