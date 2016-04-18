#cat file1
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):] 
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )
[hahhahh]
xxoooooooo
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):] 
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )
[hahhahh]
xxoooooooo
xxoooooooo
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):]
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )
[root@liudehua test1]# sed -nr  '/ERROR/{N;/^.*ERROR/{s/^.*ERROR (.*)\..*verbose:([^,]+).*/\1#\2/g;P;D}}' file1
2015-10-22 16:07:38#found TException while converting thrift obj to bytes
2015-10-22 16:07:38#found TException while converting thrift obj to bytes
2015-10-22 16:07:38#found TException while converting thrift obj to bytes
[root@liudehua test1]# cat file1
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):] 
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )
[hahhahh]
xxoooooooo
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):] 
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )
[hahhahh]
xxoooooooo
xxoooooooo
[ERROR 2015-10-22 16:07:38.865]  [handle err(POST):]
OpFailureException(code:10001, verbose:found TException while converting thrift obj to bytes, isRetriable:true, httpStatusCode:500, codeName:SystemError, codeDescription:系统错误, serverHostname:    )




[root@liudehua test1]# sed -nr  '/ERROR/{N;/^.*ERROR/{s/^.*ERROR (.*)\..*verbose:([^,]+).*/\1#\2/g;P;D}}' file1
2015-10-22 16:07:38#found TException while converting thrift obj to bytes
2015-10-22 16:07:38#found TException while converting thrift obj to bytes
2015-10-22 16:07:38#found TException while converting thrift obj to bytes