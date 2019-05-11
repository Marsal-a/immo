dt_2014=fread(paste0(path_data,"valeursfoncieres-2014.txt.gz"),encoding = "UTF-8",check.names = T,dec=",")
dt_2015=fread(paste0(path_data,"valeursfoncieres-2015.txt.gz"),encoding = "UTF-8",check.names = T,dec=",")
dt_2016=fread(paste0(path_data,"valeursfoncieres-2016.txt.gz"),encoding = "UTF-8",check.names = T,dec=",")
dt_2017=fread(paste0(path_data,"valeursfoncieres-2017.txt.gz"),encoding = "UTF-8",check.names = T,dec=",")
dt_2018=fread(paste0(path_data,"valeursfoncieres-2018.txt.gz"),encoding = "UTF-8",check.names = T,dec=",")

dt_immo=rbindlist(list(dt_2014,dt_2015,dt_2016,dt_2017,dt_2018))
map(dt_immo,~sum(is.na(.)))
dt_immo[sample(nrow(dt_immo),100)] %>% View(title = "dt_immo")
dt_immo_light=dt_immo[,.(Date.mutation,Nature.mutation,Valeur.fonciere,No.voie,Type.de.voie,Code.voie,Voie,
                   Code.postal,Commune,Section,No.plan,Surface.Carrez.du.1er.lot,Type.local,Nombre.de.lots)]

dt_immo_light=dt_immo_light[Nombre.de.lots<3]
# dt_immo_light=dt_immo_light[Surface.Carrez.du.1er.lot!=""]
dt_immo_light=dt_immo_light[Type.local%in%c("Maison","Appartement","")]
dt_immo_light=dt_immo_light[Nature.mutation%in%c("Vente","Vente en l'état futur d'achèvement")]
dt_immo_light[,Date.mutation:=as.Date(Date.mutation,"%d/%m/%Y")]

dt_immo_light[,.(mean(Valeur.fonciere,na.rm=T)),by=.(Commune,year(Date.mutation))][order(Commune)] %>% View()
dt_immo[Commune=="NANTES" & Valeur.fonciere==7560000] %>% View(title = "7560000")