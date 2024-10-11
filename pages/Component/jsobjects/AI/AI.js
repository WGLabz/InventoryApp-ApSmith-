export default {
	description :GetComponent.data[0].description,
	setDescription(content){
		this.description = content;
	},
	async generateDescription(){
		var res = await GenerateDescriptionGemini.run({
			part: GetComponent.data[0].name
		});
		
		showAlert('Component description generated','success');
		this.setDescription(res.candidates[0].content.parts[0].text)
		return res.candidates[0].content.parts[0].text;
	}
}