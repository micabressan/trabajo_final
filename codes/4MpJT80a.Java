public ArrayList<Course> getCoursesByUnitCredits(double credits)
{

Set<Unit> delkurser = getUnitsByCredits(credits);
ArrayList<Course> kurser = new ArrayList<Course>();

for(Unit u : delkurser)
{
if(u.getCredits() >= credits)
{
for(Course c : kurser){
if(c.getcCode() != u.getCourse().getcCode())
{
kurser.add(u.getCourse());
}}
}
}

return kurser;
}