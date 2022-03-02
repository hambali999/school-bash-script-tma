#!/bin/bash

while [ true ]; #to allow constant prompting
 do
 echo "Enter a folder name: " #display message Enter a folder name: to user
 read folderName #read userinput and store it as variable folderName
 if [ -d "$folderName" ]; #validation check if folder name is inside the directory
  then #if yes,
  echo "$folderName exists in the directory" #display folder exist to the user
  break #break out of the while loop
 else  #if not able to find the folder in the directory
  echo "$folderName folder name does not exist in the directory. " #display to the user the fol$
 fi #end of the if statement
done #end of while loop statement

#if folder exist in the directory,

#part c
#validation check to check her user's input USERNAME if it exist in the linux OS
while [ true ]; #use while loop here,
 do
 echo "Enter a USERNAME: " #prompt user to enter a USERNAME of the linux OS
 read username #store it into the variable username
 userexists=$(grep -c "^$username:" /etc/passwd) #here, we find all the username's that is in the linux OS /etc/passwd directory and pass it into a variable 
 if [ "$userexists" -eq 0 ]; #if the username  does not exist in the linux OS
  then 
  echo "The user $username does not exist " #output that the username does not exist
 else #continue with the while loop to continue to prompt the user for a valid username in the linux OS
  echo "The user $username exists" #output that the username exist in the linux OS
  break #break while loop
 fi #end of if statement
done 

CURRENTDATE=$(date +"%d%m%Y") #get the date today, in %d%m%Y format DDMMYYYY
if [ -d "$username-$CURRENTDATE" ];  #check if the foldername exist in the fomat USERNAME-DDMMYYYY
 then #if exist
 echo "There is an existing folder name that has the same name, hence that folder will be deleted" #output to the user it exist, and will be deleted first
 rmdir "$username-$CURRENTDATE" #delete that directory
fi
mv "$folderName" "$username-$CURRENTDATE" #now create/move the folder with the new name and all the files and the folder, sub-folders into the new folder with the new name

newFolderName=("$username-$CURRENTDATE") #store the new foldername in this variable to be used later on in the script
currentDirectory=$(pwd) #store the current directory in this variable to be used later
newFolderDirectory="$currentDirectory/$newFolderName" #here I gotten the new folder directory to be used in the script further on

#here to show all images files with png, gif extensions in an order of png first then gif
echo "List of .png and .gif files"
find "$newFolderDirectory" -type f -regex ".*\png" #list out all images files with the extension of .png first
find "$newFolderDirectory" -type f -regex ".*\gif" #then now list out all images files with the extension of .gif

#here to calculate all the images .png,.gif sizes and total it out with using the regex method to get the files that ends with .png and .gif, the script includes a cut so that i can get the number only
imagesSize=$(find "$newFolderDirectory" -type f -regex ".*\.\(png\|gif\)" -exec wc -c {} + | tail -n 1 | cut -d' ' -f 1)
echo "Total image sizes of .png and .gif : $imagesSize" #output ot the user the total image size

if [ $imagesSize -gt 200000 ] #if the total size of the png and gif image files are greater than 200KB
 then
 echo "total image size is NOT small" #output accordingly if total image size is greater than 200KB
else
 echo "total image size is small" #output accorindlgy if total image size is small
fi #end of if statement

chown -R "$username:$username" "$newFolderDirectory" #to change owner and group of the folder, sub-folders and all files to the username inputed by the user

find "$newFolderDirectory" -type d -exec chmod 764 {} \; #to change the permission of the folder and its sub-folders accordingly.
find "$newFolderDirectory" -type f -exec chmod 764 {} \; #to change the permission of all files accordingly

totalSizeOfDirectory=$(du -sh "$newFolderDirectory") #get the total size of the folder, sub-folders

countNoOfImageFiles=0 #this variable to store as the count for the number of gif and png files
declare -i countNoOfImageFiles #as stated, declare countNoOfImageFiles as integer
listOfPng=$(find "$newFolderDirectory" -type f -regex ".*\png") #get the list of png files and store it to the variable
listOfGif=$(find "$newFolderDirectory" -type f -regex ".*\gif") #get the list of gifs and store it to the variable

for i in $listOfPng #for loop the list of pngs..
do
 countNoOfImageFiles+=1 #increment..
done

for j in $listOfGif #for loop the list of gifs
do
 countNoOfImageFiles+=1 #increment..
done

#this is the summary
echo "  "
echo "---SUMMARY---"
echo "Previous folder name: "$folderName""
echo "New folder name: "$newFolderName""
echo "Total size of the folder and sub-folders: "$totalSizeOfDirectory""
echo "Total number of .png and .gif image files: "$countNoOfImageFiles""
echo "---END OF SUMMARY---"
echo "  "
echo "END OF SCRIPT"
