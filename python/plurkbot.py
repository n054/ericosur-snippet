#!/usr/bin/env python
# encoding: utf-8

from twisted.internet import reactor, task
import plurkapi
import lxml.html as lhtml
from lxml import etree
import sys, time, datetime

client = plurkapi.PlurkAPI()
last_engadget_title_db = 'last_engadget_title.txt'

def daily_engadgets():
  last_engadget_title = read_last_engadget_title()
  url = 'http://www.engadget.com/rss.xml'
  rets = etree.parse(url).xpath('//item')
  for i in range(0, len(rets)):
    try:
      item = rets[i]
      title = item.find('title').text.strip().encode('utf-8')
      link = item.find('link').text.strip().encode('utf-8')
      link = to_tinyurl(link)
      item = link + ' (' + title + ') '
    except:
      continue

    if last_engadget_title == title:
      break

    time.sleep(60*i)
    client.addPlurk(lang='tr_ch', qualifier='says', content=item)
    print item
    if i == 0: write_last_engadget_title(title)


def befriends():
  alerts = client.getAlerts()
  if len(alerts):
    client.befriend(alerts)

def write_last_engadget_title(url):
  f = open(last_engadget_title_db, 'w')
  f.write(url.strip())
  f.close()

def read_last_engadget_title():
  f = open(last_engadget_title_db, 'r')
  ret = f.read()
  f.close()
  return ret.strip()

def to_tinyurl(url):
  tinyapiurl = "http://tinyurl.com/api-create.php?url="
  try:
    tinyurl = lhtml.parse(tinyapiurl+url).xpath("//body")[0].text_content()
  except:
    return url

  return tinyurl


if __name__ == '__main__':
  try:
    client.login('pct', 'aaaaaa')
  except:
    print 'login error'

  #t = task.LoopingCall(daily_post)
  #t.start(86400)

  # daily_engadget
  dg = task.LoopingCall(daily_engadgets)
  dg.start(300)

  # befriends
  bf = task.LoopingCall(befriends)
  bf.start(600)

  reactor.run()
 