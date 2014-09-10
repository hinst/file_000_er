package hinst;

import sys.FileSystem;

class FileZPadRenamer
{

	public function new() 
	{
		
	}
	
	public var directory: String;
	public var length: Int;
	
	public function go()
	{
		var files = FileSystem.readDirectory(directory);
		for (i in 0...files.length)
			checkRename(files[i]);
	}
	
	private function checkRename(s: String)
	{
		if (s.length < length)
			rename(s);
	}
	
	private function rename(fileName: String)
	{
		var newFileName = fileName;
		while (newFileName.length < length)
			newFileName = '0' + newFileName;
		FileSystem.rename(directory + '/' + fileName, directory + '/' + newFileName);
	}
	
}