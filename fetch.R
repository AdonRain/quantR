# source('fetch.R', encoding='utf-8')

if(!exists('getURL')){
  library('RCurl');
}

load('.RData');

if(exists('date.end')){
  date.start <<- date.end + 1;
}else{
  date.start <<- as.Date('2011-05-03');
}

date.end <- Sys.Date();

if(date.start < date.end){
  pel <- lapply(getURL(lapply(seq(date.start, date.end, 'day'), function(day) {
    return(paste('http://www.csindex.com.cn/sseportal/csiportal/syl/hytype.do?code=3&zb_flg=2&db_type=0',
      paste('date', day, sep = '='),
      sep = '&'));
  }), httpheader = c(
    'Accept' = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Encoding' = 'gzip, deflate, sdch',
    'Accept-Language' = 'zh-CN,zh;q=0.8,en;q=0.6,ja;q=0.4',
    'Cache-Control' = 'no-cache',
    'Connection' = 'keep-alive',
    'Cookie' = 'JSESSIONID=7148E3D743E405986269AD314D6707FF; JSESSIONID=FC1E713D85753BC8BADF8F987597D2E5',
    'Host' = 'www.csindex.com.cn',
    'Pragma' = 'no-cache',
    'Upgrade-Insecure-Requests' = '1',
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36'
  ), .encoding="gbk"), function(html) {
    tmpMode <- regexpr(';沪深A股</div></td>\\r\\n\\t\\t\\t\\t <td width=\"10%\"><div align=\"right\">\\d+\\.\\d+&nbsp;&nbsp;</div>', html);
    if(tmpMode[1] != -1){
      tmpStr <- regmatches(html, tmpMode);
      tmpStr <- sub(';沪深A股</div></td>\\r\\n\\t\\t\\t\\t <td width=\"10%\"><div align=\"right\">', '', tmpStr);
      tmpStr <- sub('&nbsp;&nbsp;</div>', '', tmpStr);
      return(tmpStr);
    }
  });

  if(exists('pev')){
    pev <<- c(pev, as.vector(unlist(pel)))
  }else{
    pev <<- as.vector(unlist(pel));
  }
}

npev <- as.numeric(pev);

plot(npev, type='l');
abline(h=max(npev), col='red');
abline(h=min(npev), col='blue');
abline(h=mean(npev), col='green');
abline(h=median(npev), col='gold');

print(paste('最新日期', date.end, sep='：'));
