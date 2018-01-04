package main

import (
	"reflect"
	"database/sql"
)

func TryCall(Func interface{}, Args... interface{}) []interface{} {
	var valuesArgs []reflect.Value

	for _, arg := range Args {
		valuesArgs = append(valuesArgs, reflect.ValueOf(arg))
	}

	retLen := reflect.TypeOf(Func).NumOut()
	f := reflect.ValueOf(Func)
	ret := f.Call(valuesArgs)
	err, ok := ret[retLen - 1].Interface().(error)
	if ok || ret[retLen - 1].Interface() == nil {
		if err != nil {
			panic(err)
		}
		var returns []interface{}
		for _, val := range ret[:retLen-1] {
			returns = append(returns, val.Interface())
		}

		return returns
	}
	panic("Function doesn't return err as last parameter")
}

func GetChainBlocks(docID int, blockID int) (blocksRet []Block, err error){
	defer func() {
		if r := recover(); r != nil {
			err = r.(error)
		}
	}()

	driver := "postgres"
	dataSource := "user=roman password=1234512345 dbname=docnota host=192.168.88.221 sslmode=disable"

	db := TryCall(sql.Open, driver, dataSource)[0].(*sql.DB)

	query := "WITH RECURSIVE get_all_parents(id, parent_id, level, content, name) AS( " +
		"SELECT block.id, db.parent_block, 0, block.content, block.name " +
		"FROM block JOIN doc_block db ON block.id = db.block_id " +
		"WHERE db.doc_id = $1 AND block.id = $2 " +
		"UNION ALL " +
		"SELECT block.id, db.parent_block, level+1, block.content, block.name " +
		"FROM block JOIN doc_block db ON block.id = db.block_id " +
		"JOIN get_all_parents gap ON gap.parent_id = db.block_id " +
		") SELECT name, content, parent_id FROM get_all_parents ORDER BY id "
	rows := TryCall(db.Query, query, docID, blockID)[0].(*sql.Rows)
	defer rows.Close()

	blocks := make([]Block, 0)
	for rows.Next(){
		block := new(Block)
		TryCall(rows.Scan, &block.Name, &block.Text, &block.Parent)
		blocks = append(blocks, *block)
	}
	TryCall(rows.Err)
	return blocks, nil
}