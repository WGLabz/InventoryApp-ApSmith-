export default {
	async getCommits(){
		var githubURL = Input1Copy.text;
		if(!!githubURL){
			const urlParts = githubURL.split('/');

			var commits = await Github.run({
				username:urlParts[3],
				reponame:urlParts[4]
			});
	
			return commits.map(commit => ({
				author: commit.commit.author.name,
				message: commit.commit.message,
				date: moment(commit.commit.author.date).format('MMM DD, YYYY')
			}));
		}else{
			return [{
				author:'',
				message:'',
				date: ''}];
		}
	}
}