class LogRecord(val config: LoganConfiguration, val id: Int, val rawData: String, val startTime: util.Date) {

  private var columns: Array[LogRecordColumn] = config.columnData
  private var data: Array[AnyRef] = null

  override def toString = "[" + id + "]: " + rawData

  def setColumnData(columns: Array[LogRecordColumn]) {
    this.columns = columns
  }

  def set(name: String, value: AnyRef) = {
    val index = findIndex(name)
    data(index) = value
  }

  def get(columnName: String): AnyRef = {
    if (data == null) parseData()

    val index: Int = findIndex(columnName)

    if (index == -1) null
    else data(index)
  }

  def findIndex(columnName: String): Int = {
    val index = {
      var result = -1
      for (i <- columns.indices) {
        if (columns(i).name == columnName) result = i
      }
      result
    }
    index
  }

  def get(index: Int): AnyRef = {
    if (data == null) parseData()

    if (data == null) null
    else data(index)
  }
  private def parseData() {
    data = new Array[AnyRef](columns.length)
    config.parse(this)
  }
}