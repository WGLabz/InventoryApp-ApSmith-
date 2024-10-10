export default {
	async upload () {
		let description = FilesDescription.text;
		let relaventFiles = RelaventFiles.files;
		let projectID = appsmith.URL.queryParams.id; 
		
		relaventFiles.map(async (file) => {
			let fileName = file.name;
			let fileType =file.type;
			await SaveFileToMinIO.run({
				filename: fileName,
				content: file,
				projectid: projectID
			});
			await AddFile.run({
				projectid:projectID,
				filename:fileName,
				bucket:'inventoryms',
				filetype :fileType,
				description: description
			})
		})
		showAlert('File(s) added sucessfully','success')
	},
	async downloadLink(row){
		let file = await GetFileFromMinIO.run({
			bucket: row.minio_bucket,
			path: "projectfiles/"+row.project_id+'/'+row.minio_file_name
		});
		return {content:"data:"+row.minio_file_type+";base64,"+file.fileData,name: row.minio_file_name};
	}
}