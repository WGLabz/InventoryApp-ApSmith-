export default {
	description:GetProject.data[0].videodetails ,
	script:GetProject.data[0].videoscript,
	setDesription(content){
		this.description= content;
	},
	setScript(content){
		this.script
		 = content;
	},
	async generateDescription(){
		var res = await GenerateProjectDescription.run({
			project: GetProject.data[0].name
		});
		showAlert('Video description generated','success');
		this.description =  res.candidates[0].content.parts[0].text;
	},
	async generateScript(){
		var res = await GenerateVideoScript.run({
			project: GetProject.data[0].name
		});
		showAlert('Video script generated','success');
		this.script =  res.candidates[0].content.parts[0].text;
	}
}