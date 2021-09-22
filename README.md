# derailed
CVE-2021-40875: Improper Access Control in Gurock TestRail versions < 7.2.0.3014 resulted in sensitive information exposure. A threat actor can access the /files.md5 file on the client side of a Gurock TestRail application, disclosing a full list of application files and the corresponding file paths. The corresponding file paths can be tested, and in some cases, result in the disclosure hardcoded credentials, API keys, or other sensitive data.

# Credits
John Jackson
Twitter: https://twitter.com/johnjhacking

SickCodes
Twitter: https://twitter.com/sickcodes


# Summary
Why use this script? Why not just build a standard list of sensitive files? 
Building a custom list would certainly work, however, in many cases it was observed that the TestRail application had custom files - which would be good to check during the recon phase. If you want, you can run the python script to grab a custom list of files to check with dirsearch. This is a more manual method if you're not interested in downloading any of the files, otherwise, just run the bash script to do everything for you.

# Usage

Python Script
```
git clone https://github.com/SakuraSamuraii/derailed.git
cd ./derailed
python3 derailed.py
---> give it the url of the target without the md5 path (https://foo.com)
```
Run dirsearch or your preferred fuzzing tool against the list. You'll noticed that a lot of the files a fairly standard in size (0B/15B or 25B/31B/32MB -- avoid those files as they are likely of no use to you)
```
sudo dirsearch -w derailed.txt -u 'https://foo.com' -x 300,301,302,303,304,305,400,401,402,403,404,405,406,500,501,502,503,504 > paths.txt
```

Running the Bash Script (Note - will download the files into an output folder, proceed with caution)
```
bash derailed.sh 'https://target'

```
