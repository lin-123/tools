message from redis save to mysql 

接收外部消息【消息参数： rediskey】， 执行操作， 从redis 中取出 所有消息，存到mysql 中。 

若存数据成功， 则返回 null
失败， 则返回已存数据的 length， 以便在redis 中销毁

这样每次执行本服务时就可以直接取redis所有数据， 存进mysql；


若存数据出错， 则返回出错时messageid， 以便在下次取redis
每次存储成功的数据都要在redis 中销毁， 
