export AWS_ACCESS_KEY_ID=ASIAVS4F2WJD4MXY5H67
export AWS_SECRET_ACCESS_KEY=oEcVXt27c5vmSdVlcb5QkGencPkhWwdcezLv76+e

export AWS_SESSION_TOKEN==FwoGZXIvYXdzEKL//////////wEaDOu31dqucPl8jW4fRCLGATHBSS8MojcaB5zeZe9U6s91aNgGBEmBYbHeQ5GIHR4qrmzxfp4Tf4n2LXdzC2G7UXNHQk3D+obY7qTjo4rCswsSxqK8Frx4im0o1NVskDVZTN8KLmgM4RVuHKV6KG0BnoPL4jhCSGGM07xzQhuHM4RE8cqbw/gSKYPa1ZhduaDlu8T/kehXiGrSRk1AWA+ydjuqaWiCgqQXqdNsVxYPXnA//Qt+9di3eiHtJtsm+xSrC6jLyuGwL9OP+AMkICdsRATeK5Be+SjRtLqtBjItDpbqutO9i5x7B764FcGFFiYpd7Xoh6Eknlfkg/wHRp8HhheLqE7+4hvFEK2H
export AWS_DEFAULT_REGION=us-east-1
aws cloudformation deploy \
--template-file apache-tomcat-daweb/basic-stack-yaml/main.yml \
--stack-name "tomcat" \
--capabilities CAPABILITY_NAMED_IAM