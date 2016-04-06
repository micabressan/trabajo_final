public class Field
{
 protected Coordinate coord;
 protected boolean hasMine;
 protected boolean hasFlag;
 protected boolean isOpened;
 protected int neighbourMineCount;

 public Field(Coordinate coord)
 {
  this.coord = coord;
  this.hasMine = false;
  this.isOpened = false;
  this.neighbourMineCount = 0;
 }

 public Coordinate getCoordinate()
 {
  return this.coord;
 }

 public boolean hasFlag()
 {
  return this.hasFlag;
 }

 public void setHasFlag(boolean flag)
 {
  this.hasFlag = flag;
 }

 public boolean hasMine()
 {
  return this.hasMine;
 }

 public void setHasMine(boolean mine)
 {
  return this.hasMine;
 }

 public boolean isOpened()
 {
  return this.isOpened;
 }

 public void setOpened(boolean opened)
 {
  this.isOpened = opened;
 }

 public int getNeighbourMineCount()
 {
  return this.neighbourMineCount;
 }

 public void setNeighbourMineCount(int count)
 {
  if(count < 0) {
   throw new IllegalArgumentException("Wird darf nicht negativ sein!");
  }
  this.neighbourMineCount = count;
 }

}