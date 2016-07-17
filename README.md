# muni_prediction_tracker
picks a few muni routes/stops we care about and dumps them into our house event database.

muniPoller.rb was called from cron and webhooked into our house Jut install. RIP Jut.io

muniExporter is a prometheus exporter for getting muni data from a few routes we care about so we can encourage people
to move and not miss buses. 

I've been deploying it via docker. Just:

```
build: docker build -t lamont/muni_exporter .
push: docker push lamont/muni_exporter
```

(then on a docker host:)


```
pull: docker pull lamont/muni_exporter
run: docker run  -p 5000:5000 --name muni_exporter lamont/muni_exporter
```

I just picked port 5000 now, if I ever extend this to alternate routes I'll register a real prometheus port number

I've added the grafana dashboard I use as a json file, muni_grafana_dashboard.json and included a shot of the 
board in action:

![muni dashboard](https://raw.githubusercontent.com/lamont/muni_prediction_tracker/master/Muni Dashboard in Grafana.png)

