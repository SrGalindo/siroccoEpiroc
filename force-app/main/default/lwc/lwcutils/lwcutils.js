import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {getNowUTC, sumMinutes, sumHours, validateDate} from './dateUtils';
import {updateRecord} from "lightning/uiRecordApi";

/**
 * Display toasts to provide feedback to a user.
 * @param parent    Component from where is called: usually 'this'
 * @param variant   Available options: info(default), success, error, warning
 * @param title     The title of the toast, displayed as a heading.
 * @param message   A string representing the body of the message.
 */
const fireToast = (parent, variant, title, message) => {
  const showToast = new ShowToastEvent({
    title: title,
    message: message,
    variant: variant
  });
  parent.dispatchEvent(showToast);
};

const getDetailsFromError = (error) => {
  let errorDetails = '';
  if (Array.isArray(error.body)) {
    errorDetails = error.body.map(e => e.message).join(', ');
  } else if (error.body !== undefined && typeof error.body.message === 'string') {
    errorDetails = error.body.message;
  }

  return errorDetails;
};

/**
 * Validate if a boolean input component (checkbox, toggle...) is true.
 * @param parent    input component (usually the component where to display the error).
 * @param value     current value of that component (or the correspondent field).
 */

const validateInputBoolean = (parent, value) => {
  let isValid = true;
  if (parent){
    parent.setCustomValidity('');
    parent.reportValidity();
    if(value === false) {
      isValid = false;
      parent.setCustomValidity('Please complete this field.');
      parent.reportValidity();
    }
  }
  return isValid;
};

/**
 * Copies a given text to the clipboard
 * @param content the text you want to put in the clipboard. You can add line breaks by adding \n to the text
 */
const copyTextToClipboard = (content) => {
  // If the content hasn't been specified, don't do anything.
  if (!content) {
    console.log('copyTextToClipboard not run. No content passed to the library.');
    return;
  }
  // Create an input field with the minimum size and place in a not visible part of the screen
  let tempTextAreaField = document.createElement('textarea');
  tempTextAreaField.style = 'position:fixed;top:-5rem;height:1px;width:10px;';

  // assign the content we want to copy to the clipboard to the temporary text area field
  tempTextAreaField.value = content;

  // append it to the body of the page
  document.body.appendChild(tempTextAreaField);

  // Select the content of the temporary markup field
  tempTextAreaField.select();

  // Run the copy function to put the content to the clipboard
  document.execCommand('copy');

  // remove the temporary element from the DOM as it is no longer needed
  tempTextAreaField.remove();
}

/**
 * Copies a given text to the clipboard and shows a confirmation toast.
 * @param content the text you want to put in the clipboard. You can add line breaks by adding \n to the text
 * @param parent this is required to be able to show the toast. You can typically pass 'this' from the caller component.
 *  If the parent is not passed the toast won't be fired, but the text will be copied anyway.
 * @param toastVariant (optional) when informed sets that value as the variant of the fired toast ['info'|'success'|'error']. Default 'success'
 * @param toastTitle (optional) when informed it will be used as the title of the toast. Default 'Copied!'
 * @param toastMessage (optional) when informed it will be used as the text body of the toast. Default 'Text copied to clipboard!'
 */
const copyTextToClipboardWithToast = (content, parent, toastVariant, toastTitle, toastMessage) => {
  copyTextToClipboard(content);
  if (parent && content) {
    fireToast(parent, toastVariant || 'success', toastTitle || 'Copied!', toastMessage || 'Text copied to clipboard!');
  } else {
    console.log('copyTextToClipboardWithToast - Toast not shown. The parent HTML element or the content was not passed, null or undefined.');
  }
}

const populateInputSelectFields = (getPicklistValues) => {
	let res = [];
	return getPicklistValues()
		.then(result => {
			res = Object.keys(result).map(function(fieldname) {
				let opts = [];
				let values = result[fieldname];
				if (true) {
					opts.push({'class': 'optionClass', label: '', value: ''});
				}
				for(var i=0;i < values.length; i++) {
					opts.push({'class': 'optionClass', label: values[i], value: values[i]});
				}
				return opts;
			});
			return res;
		});
}
/** Refresh current record page. It's used instead of 'e.force:refreshView’
		event in Aura components
**/
const updateRecordView = (currentId) => {
	let record = {
		fields: {
			Id: currentId
		},
	};
	updateRecord(record);
}

/**
 * Validates that a string is a GUID.
 * @param guid  GUID to validate.
 */
const validateGUID = (guid) => {
  let valid = true;
  const pattern = RegExp('^(\\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\\}{0,1})$');
  valid = pattern.test(guid);
  return valid;
}

/**
 * Validates that a string is an EMAIL.
 * @param email  Email to validate.
 */
const validateEmail = (email) => {
  let valid = true;
  const pattern = RegExp('^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,9}$');
  valid = pattern.test(email);
  return valid;
}

const validateStandardFields = (template, queryFields) => {
  let fields = template.querySelectorAll(queryFields);
  return [...fields].reduce((validSoFar, inputCmp) => {
    inputCmp.reportValidity();
    return validSoFar && inputCmp.checkValidity();
  }, true);
}

export { fireToast, getDetailsFromError, validateInputBoolean,
         copyTextToClipboard, copyTextToClipboardWithToast,
         populateInputSelectFields, getNowUTC, sumMinutes,
         sumHours, validateDate, updateRecordView, validateGUID, validateEmail, validateStandardFields};