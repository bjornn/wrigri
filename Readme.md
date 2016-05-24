# Write In A Grid

Write In A Grid is a method where several documents are written up simultaneously in a spreadsheet program. You can then use this program to generate stand-alone-documents from the master document. 

The Write in a grid method can be productive when 

* You write many documents of similar type with a large degree of overlap and repetition (e.g. functional specifications, requirements, RFCs). 
* You are collecting data from many authors and want them to fill in a form with a lot of instructive text that shall not be present in the end product.
* You need to quality assess information from many sources by keeping them in one place.
* You need to maintain multiple instances of documents in different languages and want to be able to work on them side by side. 
    
The basis for Write In A Grid is 
 
 * Document section headers (keys) are stored in one column. 
 * Data for one document instance is then represented in another column (values). 
 * One additional column is reserved for output formatting instructions. 

This software allows you to generate output from such a grid in either html-, ReStructured Text or Markdown format.

## Input

### Requirement on the input file

* The input file must be semicolon separated in UTF-8 format without BOM. 
* No linebreaks (or carriage return) can be present in one row before the end of line (excel issue with paragraph handling.).
* Key and formatting column indexes in the index must agree with the values  


## Output 

### Output formatting instructions

| Command | Meaning            | Key                 | Value                      |
| ---     | ---                | ---                 | ---                        |
| -       | Comment            | Ignored             | Ignored                    |
| ds      | Document start     | Document title      | Ignored                    |
| de      | Document end       | Ignored             | Ignored                    |
| ts      | Table start        | Value in first cell | Value in second cell       |
| tr      | Table row          | Value in first cell | Value in second cell       |
| tro     | Table with one row | Value in first cell | Value in second cell       |
| te      | Table end          | Value in first cell | Value in second cell       |
| img     | Image              | Image alt text      | Image url                  |
| imgCap  | Image caption      | Ignored             | Value of caption           |
| ss      | Sub section        | Subsection header   | subsection first paragraph |
| sh      | Section header     | Header              | Ignored                    |

### Output HTML

* The style of the output can be controlled by putting a css file named style.css in the same directory as the generated html file.

## Configuration

The master document layout is described in a configuration file. An example configuration file (configuration.ini) matching the example data (ExampleData.csv) is provided in this project.

Different configuration files can be used to generate different output.

### Configuration parameters

TBD

