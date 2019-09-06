#!/usr/bin/env python3

import json
import requests
import datetime
import smtplib
import logging

EMAIL_ADDRESS = {{ EMAIL_ADDRESS }}
EMAIL_PASSWORD = {{ EMAIL_PASSWORD }}

def notify_user():
    with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
        smtp.ehlo()
        smtp.starttls()
        smtp.ehlo()

        smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)

        subject = 'WARNING - JADE'
        body = 'There seems to be a problem with the Erste Bank Card Manager. Please check the logs and investigate.\n\nBot'
        msg = f'Subject: {subject}\n\n{body}'

        smtp.sendmail(EMAIL_ADDRESS, EMAIL_ADDRESS, msg)

with open('{{ PATH }}/query', 'r') as file:
    query = file.read()

response = requests.get('http://127.0.0.1:9200/heartbeat-7.3.1/_search', data=query, auth=({{ USERNAME }}, {{ PASSWORD }}), headers={"content-type": "application/json"}).json()

logging.basicConfig(filename='pythonlogs', filemode='a', format='%(asctime)s - %(message)s')

if response["hits"]["total"]["value"] > 5:
    logging.error('WARNING: Problem with server, email sent to sysadmin')
    notify_user()
else:
    logging.error('INFO: Server is up and running')
