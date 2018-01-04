func GetChainBlocks(docID int, blockID int) ([]Block, error){
	db, err := sql.Open("postgres", "user=roman password=1234512345" +
		" dbname=docnota host=192.168.88.221 sslmode=disable")
	if err != nil{
		return nil, err
	}

	query := "WITH RECURSIVE get_all_parents(id, parent_id, level, content, name) AS( " +
	"SELECT block.id, db.parent_block, 0, block.content, block.name " +
	"FROM block JOIN doc_block db ON block.id = db.block_id " +
	"WHERE db.doc_id = $1 AND block.id = $2 " +
	"UNION ALL " +
	"SELECT block.id, db.parent_block, level+1, block.content, block.name " +
	"FROM block JOIN doc_block db ON block.id = db.block_id " +
	"JOIN get_all_parents gap ON gap.parent_id = db.block_id " +
	") SELECT name, content, parent_id FROM get_all_parents ORDER BY id "
	rows, err := db.Query(query, docID, blockID)
	if err != nil{
		return nil, err
	}
	defer rows.Close()
	blocks := make([]Block, 0)
	for rows.Next(){
		block := new(Block)
		err = rows.Scan(&block.Name, &block.Text, &block.Parent)
		if err != nil{
			return nil, err
		}
		blocks = append(blocks, *block)
	}
	err = rows.Err()
	if err != nil{
		return nil, err
	}
	return blocks, nil
}