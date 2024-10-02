export default {
	orderDetails: [],
	totalCost: 0,
	clearOrderData(){
		this.orderDetails = [];
	},
	addToOrder () {
		var componentName = ComponentSelect.selectedOptionLabel;
		var componentId = ComponentSelect.selectedOptionValue;
		var quantity = Number(Input1.text);
		var totalCost = Number(Input2.text);
		var image = GetComponentImage.data[0].image;

		this.orderDetails.push({
			id: this.orderDetails.length + 1,
			componentId: componentId,
			component: componentName,
			image:image,
			quantity: quantity,
			totalcost: totalCost,
			peritemcost: totalCost / quantity
		});
		showAlert('Item cached for the order','success');
		resetWidget(AddItemModal.name)
		return true;
	},
	removeFromOrder () {
		let id = Table1.selectedRow.id;
		this.orderDetails = this.orderDetails.filter( o => {
			return o.id !== id;
		})
		this.calculateTotalCost();
	},
	calculateTotalCost(){
		this.totalCost = this.orderDetails.reduce((accumulator, item) => {
			return accumulator + item.totalcost;
		}, 0);
	},
	orderData(){
		if(this.orderDetails.length > 0)
			return this.orderDetails;
		else{
			return [{
				id: 1,
				componentId: 1,
				component:'Add purchased parts',
				image:'',
				quantity: 0,
				totalcost: 0,
				peritemcost: 0
			}]
		}
	}
}