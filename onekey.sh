function getJsonValuesByAwk() {
    awk -v json="$1" -v key="$2" -v defaultValue="$3" 'BEGIN{
        foundKeyCount = 0
        while (length(json) > 0) {
            # pos = index(json, "\""key"\"");
            pos = match(json, "\""key"\"[ \\t]*?:[ \\t]*");
            if (pos == 0) {if (foundKeyCount == 0) {print defaultValue;} exit 0;}

            ++foundKeyCount;
            start = 0; stop = 0; layer = 0;
            for (i = pos + length(key) + 1; i <= length(json); ++i) {
                lastChar = substr(json, i - 1, 1)
                currChar = substr(json, i, 1)

                if (start <= 0) {
                    if (lastChar == ":") {
                        start = currChar == " " ? i + 1: i;
                        if (currChar == "{" || currChar == "[") {
                            layer = 1;
                        }
                    }
                } else {
                    if (currChar == "{" || currChar == "[") {
                        ++layer;
                    }
                    if (currChar == "}" || currChar == "]") {
                        --layer;
                    }
                    if ((currChar == "," || currChar == "}" || currChar == "]") && layer <= 0) {
                        stop = currChar == "," ? i : i + 1 + layer;
                        break;
                    }
                }
            }

            if (start <= 0 || stop <= 0 || start > length(json) || stop > length(json) || start >= stop) {
                if (foundKeyCount == 0) {print defaultValue;} exit 0;
            } else {
                print substr(json, start, stop - start);
            }

            json = substr(json, stop + 1, length(json) - stop)
        }
    }' | sed 's/^"\(.*\)"$/\1/'
}
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
sudo apt-get update
sudo apt-get -y install libssl1.1
JSON=`curl https://api.github.com/repos/damomine/aleominer/releases/latest`
VERSION=$(getJsonValuesByAwk "$JSON" "tag_name")
DOWNLOAD_URL=$(getJsonValuesByAwk "$JSON" "browser_download_url")
echo "the last version" $VERSION
if [ ! -d /opt/damominer_$VERSION  ];then
  sudo mkdir /opt/damominer_$VERSION
  sudo curl -L $DOWNLOAD_URL -o /opt/damominer_$VERSION.tar
  sudo tar xvf /opt/damominer_$VERSION.tar -C /opt/damominer_$VERSION
  sudo chmod +x /opt/damominer_$VERSION/damominer
  sudo killall damominer
else
  echo version exist
fi

if ps aux | grep 'damominer' | grep -q 'proxy'; then
    echo "DamoMiner already running."
    exit 1
else
    echo '' > /tmp/aleo.log
    echo "DamoMiner is running."
    sudo nohup /opt/damominer_$VERSION/damominer --address $1 --proxy asiahk.damominer.hk:9090 >> /tmp/aleo.log 2>&1 &
    echo "Your address is $1"
fi
sleep 5
sudo tail /tmp/aleo.log
