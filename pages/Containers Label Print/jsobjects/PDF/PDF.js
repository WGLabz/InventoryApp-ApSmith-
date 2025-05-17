export default {
  generateLabelPDF: async () => {
    let labelWidthInches = parseFloat(Input1Copy.text);  // Convert to float for size calculation
    let labelHeightInches = parseFloat(LabelHeight.text);  // Convert to float for size calculation
    let selectedContainersArray = SelectedContainers.selectedOptionValues;

    let labelData = GetContainers.data.filter((c) => {
      return selectedContainersArray.indexOf(c.box_id) > -1;
    });
    // Create duplicate for each container to print 2 labels each
    labelData = labelData.flatMap(item => [item, { ...item }]);

    // Load jsPDF from the CDN
    const pdf = jspdf.jsPDF({
      unit: 'in', // Use inches for measurement
      format: 'a4', // A4 format
    });

    // Get page dimensions
    const pageWidth = 8.27;
    const pageHeight = 11.69;

    // Padding between labels
    const padding = 0.1;

    // Increase the scaling factor for the QR code and font size
    const qrCodeSize = Math.min(labelWidthInches, labelHeightInches) * 0.85;
    const fontSize = Math.min(labelWidthInches, labelHeightInches) * 10;
    const textBold = 'bold';

    pdf.setFont('helvetica', textBold);
    pdf.setFontSize(fontSize);

    let x = 0;
    let y = 0;

    for (const label of labelData) {
      // Check if the next label would exceed the page height considering margin
      if (y + labelHeightInches + padding > pageHeight) {
        pdf.addPage();
        x = 0;
        y = 0;
      }

      // Move to the next row if the label exceeds page width
      if (x + labelWidthInches + padding > pageWidth) {
        x = 0;
        y += labelHeightInches + padding;

        // Check again after moving to the next row
        if (y + labelHeightInches + padding > pageHeight) {
          pdf.addPage();
          x = 0;
          y = 0;
        }
      }

      const qrCodeImage = QRCodeGenerator.generate(label.box_id);
      pdf.addImage(qrCodeImage, 'PNG', x + padding, y + padding, qrCodeSize, qrCodeSize);

      pdf.text(`${label.box_code}`, x + qrCodeSize + padding * 2, y + padding + fontSize / 72);

      const wrappedLabelText = pdf.splitTextToSize(`${label.box_label}`, labelWidthInches - qrCodeSize - padding * 3);
      pdf.text(wrappedLabelText, x + qrCodeSize + padding * 2, y + padding + (fontSize / 72) * 3);

      pdf.rect(x, y, labelWidthInches, labelHeightInches);

      x += labelWidthInches + padding;
    }

    const base64PDF = pdf.output('datauristring');
    return base64PDF;
  }
}
