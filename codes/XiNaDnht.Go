/*
Response example
{
    "result_count": 2,
    "images": [
    {
        "id": "<creative image id>}",
        "asset_family": "creative",
        "caption": "<image description>",
        "collection_code": "<collection code>",
        "collection_id": <collection id>,
        "collection_name": "<collection name>",
        "display_sizes": [
        {
            "is_watermarked": false,
            "name": "thumb",
            "uri": "<display url>"
        }
        ],
        "license_model": "rightsmanaged",
        "max_dimensions": {
        "height": 2738,
        "width": 4442
        },
        "title": "<image title>"
    }
    ]
}
*/

type ResponseJson struct {
    Result_count int `json:"result_count"`
    Images []Image `json:"images"`
}

type Image struct{
  Id int `json:"id"`
  Asset_family string `json:"asset_family"`
  Caption  string `json:"caption"`
  Collection_code  int `json:"collection_code"`
  Collection_id int `json:"collection_id"`
  Collection_name  int `json:"collection_name"`
  Display_sizes []DisplaySize
  License_model string `json:"license_model"`
  Max_dimensions Dimension `json:"max_dimensions"`
  Title string  `json:"title"`
}

type  DisplaySize struct{
  Is_watermarked bool `json:"is_watermarked"`
  Name string  `json:"name"`
  Uri string  `json:"uri"`
}

type Dimension struct{
  Height int `json:"height"`
  Width int `json:"width"`
}

func getJson(client *http.Client, url , query string, target interface{}) error {
    req, err := http.NewRequest("GET", url, nil)
    if err != nil {
        log.Printf("Error in reques: %s", err)
    }
    req.Header.Add("Api-Key", gettyimagescomApiKey)
    q := req.URL.Query()
    q.Add("phrase", query)
    req.URL.RawQuery = q.Encode()

    log.Println(req.URL.String())

    resp, err := client.Do(req)
    if err != nil {
        return err
    }
    defer resp.Body.Close()

    return json.NewDecoder(resp.Body).Decode(target)
}