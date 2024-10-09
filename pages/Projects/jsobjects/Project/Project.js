export default {
	async createProject () {
		let name = ProjectName.text;
		let description = ProectDescription.text;
		let date = ProjectStartDate.selectedDate;
		let isYTVideo =IsYoutubeVideo.isSwitchedOn;

		var res = await CreateProject.run({
			name:name,
			date:date,
			description:description,
			ytvideo: isYTVideo
		});
		if(!!res){
			showAlert('Project successfully created!','success');
		}
		if(isYTVideo){
			let projectID = res[0].id;
			let pCreated = await CreateVideo.run({
				title: name,
				projectid: projectID,
			});
			let videoID = pCreated[0].id;
			await AddVideoStatus.run({
				videoid: videoID
			});
			showAlert('Youtube Video details initialized!','success');
		}
	},
	async deleteProject () {
		let videoStatusID = Table2.selectedRow.videostatusid;
		let videoID =  Table2.selectedRow.videoid;
		let projectID = Table2.selectedRow.projectid;

		if(!!videoStatusID){
			await DeleteVideoStatus.run({
				id: videoStatusID
			});
			showAlert('Project related video status removed', 'success');
		}
		if(!!videoID){
			await DeleteVideo.run({
				id: videoID
			});
			showAlert('Project related video removed', 'success');
		}
		if(!!projectID){
			await DeleteProject.run({
				id: projectID
			});

			showAlert('Project removed', 'success');
		}
		await GetProjects.run()
	}
}