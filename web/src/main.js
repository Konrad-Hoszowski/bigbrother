const Restify = require('restify');
const Fs = require('fs');
const Path = require('path');


const SCREENS_PATH = "/opt/bigbrother/screens";


function listSubFolders(folderPath){
    return Fs
    .readdirSync(folderPath)
    .filter( item => Fs.statSync(Path.join(folderPath, item)).isDirectory() )
    .sort();
}

function listImageFiles(folderPath){
	var extension = ".jpg";
	try{
	    return Fs
	    .readdirSync(folderPath)
	    .filter( item => Fs.statSync(Path.join(folderPath, item)).isFile() && 
	    							 Path.extname(item) === extension)
	    .sort().reverse();
	}catch (err){
		console.log(err);
		return null;
	}
}

function getUsers(){
	var screensFolders = listSubFolders(SCREENS_PATH);
	var users = [];
	for ( folder of screensFolders){
		users.push({
			name: folder,
			folder: Path.join(SCREENS_PATH, folder),
			timestamp: Date.now()
		})
	}
	return users;
}

function getUserDetails(user){
	var imageFiles = listImageFiles(Path.join(SCREENS_PATH, user));
	var user = {
		name: user,
		folder: SCREENS_PATH,
		imageFiles: imageFiles,
		lastImage: (imageFiles!=null) ? imageFiles[0]: null,
		timestamp: Date.now(),
	}
	return user;
}


function resUsers(req, res, next){
	res.json({users:getUsers()});
	next();
}

function resUserDetails(req, res, next){
	res.json({user:getUserDetails(req.params.name)});
	next();
}


var server = Restify.createServer({
	name: "BigBrother",
	version: "0.0.1"
});
server.pre(Restify.plugins.pre.userAgentConnection());
server.get('/users',resUsers);
server.get('/user/:name', resUserDetails);
server.get('/*', Restify.plugins.serveStatic({
    directory: __dirname + '/client' ,
    default: './index.html' 
   })
);
server.get('/screens/*.jpg', Restify.plugins.serveStatic({
    directory: SCREENS_PATH + "/.."
   })
);

server.listen(8080, function() {
  console.log('%s listening at %s', server.name, server.url);
});

