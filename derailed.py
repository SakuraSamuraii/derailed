import os
import sys
import pycurl
from io import BytesIO

# Grabbing the results of the files.md5 endpoint
b_obj = BytesIO()
crl = pycurl.Curl()
crl.setopt(crl.URL, input("Enter the URL of the Testrail App: ")+'/files.md5')
crl.setopt(crl.WRITEDATA, b_obj)
crl.perform()
crl.close()
get_body = b_obj.getvalue()
result = get_body.decode('utf8')
with open('dirlist.txt', 'w') as f:
    f.write(result)
# Fixing the results
os.system("awk '{print $2}' dirlist.txt > sorted.txt")
os.system("sed 's/^/\//' sorted.txt > derailed.txt")
os.system("rm -r dirlist.txt && rm -r sorted.txt")
