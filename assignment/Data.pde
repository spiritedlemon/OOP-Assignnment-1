//Class to read in three variables from 'data.csv'  --  see setup to see this being used

class Data
{
  String description;
  int input;
  
  
  Data(TableRow row)
  {
    
    description = row.getString(0);
    input = row.getInt(1);
    
  }
  
}//end of class