//Class to read in three variables from 'data.txt'

class Data
{
  String description;
  int input;
  
  
  Data(String line)
  {
    String[] fields = line.split("=");
    description = fields[0];
    input = Integer.parseInt(fields[1]);
    
    
  }
  
}//end of class