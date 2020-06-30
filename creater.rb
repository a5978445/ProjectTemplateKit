require 'json'
#require "FileCopyTools"

load "FileCopyTools.rb"

copyFiles()




#exit!()

# read  transfer json file
json = File.read('transfer.js')

$dic = JSON.parse(json)

$parentPath = "product"

$origin_project_name = "MyProject"

$origin_APP_name = "MyApp"
$origin_APP_unit_test_name = "MyUnitTests"
$origin_APP_ui_test_name = "MyUITests"

$origin_framework_name = "MyFramework"
$origin_framework_unitTest_name = "MyFrameworkUnitTests"


$destination_project_name = $dic["projectName"]

$destination_APP_name = $dic["demoAPPName"]
$destination_APP_unit_test_name = $dic["demoAPPName"] + "UnitTests"
$destination_APP_ui_test_name = $dic["demoAPPName"] + "UITests"

$destination_framework_name = $dic["frameworkName"]
$destination_framework_unitTest_name = $dic["frameworkName"] + "UnitTests"



def appendParentPath (fileName)
  return $parentPath + "/" + fileName
end


def replaceKeys ()
  result = ""

# use transfer.js value replace project.yml related key
  File.foreach(appendParentPath("project.yml")) { |line|

    temp = line
    # temp = temp.sub("MyProject",$dic["projectName"])
    # temp = temp.sub("MyApp",
    #   $dic["demoAPPName"])
    # temp = temp.sub("MyFramework",$dic["frameworkName"])
    # temp = temp.sub("MyFrameworkUnitTests",$dic["frameworkName"] + "UnitTests")
    # temp = temp.sub("MyUnitTests",$dic["demoAPPName"] + "UnitTests")
    # temp = temp.sub("MyUITests",$dic["demoAPPName"] + "UITests")

    temp = temp.sub($origin_project_name, $destination_project_name)
    temp = temp.sub($origin_APP_name, $destination_APP_name)
    temp = temp.sub($origin_framework_name, $destination_framework_name)
    temp = temp.sub($origin_APP_ui_test_name, $destination_APP_ui_test_name)
    temp = temp.sub($origin_APP_unit_test_name, $destination_APP_unit_test_name)
    temp = temp.sub($origin_framework_unitTest_name, $destination_framework_unitTest_name)



    result += temp



  }

# puts result


  aStringIO = StringIO.new(result)

  IO.write(appendParentPath("project.yml"), result)
end

# rename folder file
def renameFile(originFileName, destinationFileName)

  names = originFileName.chomp.split ("/")
  fileName = names[-1]


  originPath  =  originFileName + "/" + fileName + ".swift"

  destinationFilePath = originFileName + "/" + destinationFileName + ".swift"

  File.rename(originPath, destinationFilePath)

  return destinationFilePath

end


# rename head file
def renameHeaderFile(originFileName, destinationFileName)

  names = originFileName.chomp.split ("/")
  fileName = names[-1]

  originPath  =  originFileName + "/" + fileName + ".h"

  destinationFilePath = originFileName + "/" + destinationFileName + ".h"

  File.rename(originPath, destinationFilePath)

  return destinationFilePath

end


def replaceString (fileName, sourceString, destinationString)
  result = ""
# puts fileName
  File.foreach(fileName) { |line|
    result += line.sub(sourceString, destinationString)

  }

  IO.write(fileName, result)

end







replaceKeys()







MyUnitTestsFile = renameFile(appendParentPath($origin_APP_unit_test_name), $destination_APP_unit_test_name)
replaceString(MyUnitTestsFile, $origin_APP_name, $destination_APP_name)


MyFrameworkUnitTests = renameFile(appendParentPath($origin_framework_unitTest_name), $destination_framework_unitTest_name)
replaceString(MyFrameworkUnitTests, $origin_framework_name, $destination_framework_name)


renameFile(appendParentPath($origin_APP_ui_test_name), $destination_APP_ui_test_name)

renameHeaderFile(appendParentPath($origin_framework_name), $destination_framework_name)


# rename folder
File.rename( appendParentPath($origin_APP_name), appendParentPath($destination_APP_name) )
File.rename( appendParentPath($origin_framework_name), appendParentPath($destination_framework_name) )
File.rename( appendParentPath($origin_framework_unitTest_name), appendParentPath($destination_framework_unitTest_name ))
File.rename( appendParentPath($origin_APP_unit_test_name), appendParentPath($destination_APP_unit_test_name) )
File.rename( appendParentPath($origin_APP_ui_test_name), appendParentPath($destination_APP_ui_test_name) )










