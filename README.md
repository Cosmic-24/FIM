# FIM

As a B.Tech student, I created a file integrity tool that verifies the integrity and authenticity of files. My tool works by generating a hash value for each file, which is a unique digital fingerprint based on the file's content. This hash value is then compared to the original hash value generated during the file creation to ensure that the file has not been altered or tampered with.

I am proud to have developed a comprehensive and reliable solution for detecting any unauthorized changes to files. My tool can be used in a variety of contexts, from verifying the integrity of important documents to ensuring the authenticity of software and firmware updates.

This fim works by comparing self generated data i.e hashes.The hash of all the  files to be monitored is calculated and stored in the baseline folder which is the later used for monitoring.

The Base code consists of a cli version of the fim that is written in powershell that requires you to select folder to monitor and give a type of hash.
Along with this code i have added multiple addons that can be used to generate GUI for the same.
I have also added a python version of the script so that it can be used on other os such as ubuntu/kali.

Please note that this is something I developed as a student so the scope and use of this tools is limited, the purpose of this project is to  demonstrates my skills and expertise in software development and information security.
