# MSS XML Conversion Project

### This is designed to be run as an Oxygen project. To run:

##Setup a Transform Scenario
1. Create an Oxygen project called "transform.xpr"
2. Download:
-- - One XSLT file called "transform.xslt"
-- - Two folders - "In" and "Out"
3. Inside the "In" folder you should see all the JATS DTD files. The "Out" folder should be empty. 
4. Right click on the transform.xpr icon in oxygen and select "Transform" > "Configure Transform Scenario(s)..."
5. In the dialogue box that pops up, click on "New" and then select "XML with XSLT" and call your new scenario "Editorial Manager Transform Scenario". On the the line that says XML URL, leave that as "${currentFileURL}". On the line that says XSL URL, point that to the transform.xsl file in the folder you downloaded. 
6. Now, in that same dialogue box, toggle over to Output. We want to tell Oxygen where to save the .txt files we make. The files should be saved in the same place you saved the project. To make sure you have the correct file path simply save your changes and close out of that box. Then right click on the "Out" folder in Oxygen and select "Copy Location".
7. And then re-open that dialogue box by selecting "Transform" > "Configure transformation Scenario(s)" again, and paste that location into the dialogue box. After you paste the path to that folder you then need to add the following "${cfn}.txt". We're telling it to save all files in the Out folder and name them the same name as the original XML file. 

##Step 2: Run a Transform
1. Copy all you XML files into the In folder. They should live alongside the DTD files. 
2. Right-click on one or more of the XML files you want to transform and select "Apply Transform Scenario(s)". Since you already setup your transform scenario and associated it with this project, you should be ready to go and the .txt files should appear in your Out folder. 