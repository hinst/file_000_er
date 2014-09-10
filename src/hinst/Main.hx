package hinst;

import Std;
import sys.FileSystem;
import Sys;
import hinst.FileZPadRenamer;

class Main 
{
	
	public function new(args: Array<String>)
	{
		this.args = args;
	}
	
	public var args: Array<String>;
	public var directory: String;
	public var length: Int;
	
	public static function main() 
	{
		var args = Sys.args();
		var app = new Main(args);
		app.run();
	}
	
	public function checkExtractArgs(): InputStatus
	{
		var result: InputStatus = Unknown;
		if (args.length >= 1)
		{
			directory = args[0];
			if (FileSystem.exists(directory))
				if (FileSystem.isDirectory(directory))
				{
					if (args.length >= 2)
					{
						length = Std.parseInt(args[1]);
						if (length != null)
							result = Valid;
						else
							result = InvalidLength;
					}
					else
						result = LengthUnspecified;
				}
				else
					result = NotADirectory;
			else
				result = DirectoryNonExistent;
		}
		else
		{
			result = DirectoryUnspecified;
			trace('Not enough command line arguments: directory not specified');
		}
		return result;
	}
	
	public function inputStatusErrorToString(a: InputStatus): String
	{
		var result: String = '';
		if (Unknown == a)
			result = 'Unknown input error';
		else if (DirectoryUnspecified == a)
			result = 'Directory not specified. Directory should be specified as a command line argument';
		else if (DirectoryNonExistent == a)
			result = 'Directory does not exits: "' + directory + '"';
		else if (NotADirectory == a)
			result = 'Specified path is not a directory: "' + directory + '"';
		else if (LengthUnspecified == a)
			result = 'Length not specified. Length should specified in second command line argument';
		else if (InvalidLength == a)
			result = 'Could not convert specified length to Int';
		return result;
	}
	
	public function run()
	{
		var inputStatus = checkExtractArgs();
		if (inputStatus == Valid)
			proceed();
		else
			trace(inputStatusErrorToString(inputStatus));
	}
	
	public function proceed()
	{
		var renamer = new FileZPadRenamer();
		renamer.directory = directory;
		renamer.length = length;
		renamer.go();
	}
	
}

enum InputStatus 
{
	Unknown;
	Valid;
	DirectoryUnspecified;
	DirectoryNonExistent;
	NotADirectory;
	LengthUnspecified;
	InvalidLength;
}

