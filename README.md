# derailed
CVE-2021-40875: Improper Access Control in Gurock TestRail versions < 7.2.0.3014 resulted in sensitive information exposure. A threat actor can access the '/files.md5' file on the client side, disclosing files and the corresponding paths to the attacker. In some cases, many of the files are available on the client side, resulting in disclosure of hardcoded credentials, API keys, and other sensitive or proprietary data.

# Summary
Why use this script? Why not just build a standard list of sensitive files? 
Building a custom list would certainly work, however, in many cases it was observed that the TestRail application had custom files - which would be good to check during the recon phase.

# Usage

```bash

git clone https://github.com/SakuraSamuraii/derailed.git
cd ./derailed
bash  derailed.sh 'https://target'

```
