This script prompts you to enter the path to a file containing a list of IP addresses. It then runs ./ssh-audit.py on each IP, appending the results to ssh-output with dashed lines separating each IP's output. Additionally, it identifies and records IPs using weak elliptic curves in weakssh-hosts.txt. After processing all IPs, it outputs the total number of IPs with weak SSH configurations and prints "SSH Audit Completed" to signal the end of the process.

Ensure "ssh-audit.py" is installed and in the same directory.

Reference: https://github.com/arthepsy/ssh-audit

![image](https://github.com/Unidoo/sshrunner/assets/81655620/d7f7dc2f-0303-46cb-af6b-11abefb2a86a)
