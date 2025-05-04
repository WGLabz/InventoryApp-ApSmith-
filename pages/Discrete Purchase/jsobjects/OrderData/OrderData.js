export default {
	orderDetails: [],
	totalCost: 0,
	clearOrderData(){
		this.orderDetails = [];
	},
	addToOrder () {
		var componentName = existing_product_name.selectedOptionLabel || productname.text;
		var componentId = existing_product_name.selectedOptionValue || -1;
		var quantity = Number(productquantity.text);
		var totalCost = Number(productcost.text);
		var image = Product_Image.files.length > 0 ? Product_Image.files[0].data : '';
		var url_ = producturl.text;
		var category = productcategory.selectedOptionLabel;
		var categoryId = productcategory.selectedOptionValue;
		var containerId = Number(container.selectedOptionValue);

		if(componentId === -1 && !image){
			showAlert('Select a image of the part.','error');
			return false;
		}
		if(componentId === -1 && !image){
			showAlert('Select a image of the part.','error');
			return false;
		}
		if(!categoryId){
			showAlert('Select a part category','error');
			return false;
		}
		if(!containerId){
			showAlert('Select a part container','error');
			return false;
		}

		this.orderDetails.push({
			id: this.orderDetails.length + 1,
			componentId: componentId,
			component: componentName,
			image:image,
			quantity: quantity,
			totalcost: totalCost,
			peritemcost: totalCost / quantity,
			url: url_,
			category: category,
			categoryId: Number(categoryId),
			containerId: containerId
		});
		showAlert('Item cached for the order','success');
		existing_product_name.setSelectedOption(undefined);;
		productname.setValue('');
		productquantity.setValue('');
		productcost.setValue('');
		//Product_Image.;
		producturl.setValue('');
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
				urL: '',
				quantity: 0,
				totalcost: 0,
				peritemcost: 0,
				category: '',
				categoryId: 0,
				containerId: 0
			}]
		}
	}
}