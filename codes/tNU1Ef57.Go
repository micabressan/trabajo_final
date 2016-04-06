type MasteryPage struct{
  Id int32
  Name string
  Current bool
  Masteries []Mastery
}

type Mastery struct{
  Id int16
  Rank int16
}

type Masteries struct{
  Id int32
  MasteryPages []MasteryPage
}


//////////////////////////////////////////////


func getMasteriesById(id string)Masteries {
  var tmpMasteries Masteries
  var tmpDownloads map[string]Masteries
  var masteryData []byte

  masteryData = executeRequest(APIUrl+"/api/lol/"+Region+"/v1.4/summoner/"+id+"/masteries"+APIKey)

  //fmt.Printf(string(masteryData))

  json.Unmarshal(masteryData,&tmpDownloads)

  for key, value := range tmpDownloads{
    if(key==strings.ToLower(id)){
      fmt.Printf("%d",value.Id)
      tmpMasteries = value
    }
  }
  return tmpMasteries
}