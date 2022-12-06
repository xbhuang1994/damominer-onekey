## 一键启动damominer

替换你的钱包地址：aleo14fm3hd27xych5yv6ysj2n8p5wthlzmucelm0mjuu0hxsftvuc5qss8zsvc

```
curl -s https://raw.githubusercontent.com/xbhuang1994/damominer-onekey/master/onekey.sh | bash -s aleo14fm3hd27xych5yv6ysj2n8p5wthlzmucelm0mjuu0hxsftvuc5qss8zsvc
```

国内可能因为dns 原因无法解析 raw.githubusercontent.com 可使用下面加速 

```
curl -s http://106.75.166.111:38000/aleo/onekey.sh | bash -s aleo14fm3hd27xych5yv6ysj2n8p5wthlzmucelm0mjuu0hxsftvuc5qss8zsvc
```



## 停止 Miner

```
killall damominer
```

## 启动 Miner 

方案一：
替换$VERSION为V1.5.3 或更高版本
```
nohup /opt/damominer_$VERSION/damominer --address $1 --proxy asiahk.damominer.hk:9090 >> /tmp/aleo.log 2>&1 &
```
方案二:
```
curl -s http://106.75.166.111:38000/aleo/onekey.sh | bash -s aleo14fm3hd27xych5yv6ysj2n8p5wthlzmucelm0mjuu0hxsftvuc5qss8zsvc
```

## 开机自动启动
```
系统版本较多，比较复杂，不想写。如果想要请在Telegram群里面@Venus
```
