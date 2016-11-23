//Class to read in three variables from 'data.txt'

class Data
{
  String description;
  int input;
  
  
  Data(TableRow row)
  {
    //String[] fields = line.split("=");
    description = row.getString(0);
    input = row.getInt(1);
    
    
  }
  
}//end of class