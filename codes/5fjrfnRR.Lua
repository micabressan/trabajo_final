local markerTemplates={"Worldmap-Border Marker-Bal Rattha","Worldmap-Border Marker-Desolate Hills","Worldmap-Border Marker-Dwarven Marches","Worldmap-Border Marker-Dunn Ergast",
	"Worldmap-Border Marker-Sssilistra","Worldmap-Border Marker-Taltos","Worldmap-Border Marker-Erthee L'Bala","Worldmap-Border Marker-Bolfores'L",
	"Worldmap-Border Marker-Southmont","Worldmap-Border Marker-Rollingplain","Worldmap-Border Marker-The Wold","Worldmap-Border Marker-Thikken Dal",
	"Worldmap-Border Marker-Brakental","Worldmap-Border Marker-Flattan Rol"}

for u in Objects.Marker:SearchCircle(10000,0,markerTemplates) do
  u:DestroyChildObject("FX")
end