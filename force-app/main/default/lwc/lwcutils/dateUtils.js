/*
 * Returns current timestamp
 */
const getNowUTC = () => {
    let now = new Date();
    let now_utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),
        now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
    return now_utc;
};

/*
 * Adds specified amount of minutes to the currentTime
 * @param currentTime Current timestamp
 * @param minutes Amount of minutes
 * @returns aggregated value (timestamp_
 */
const sumMinutes = (currentTime, minutes) => {
    currentTime = new Date(currentTime);
    let hours = currentTime.getUTCHours();
    minutes = currentTime.getUTCMinutes() + minutes;

    if (minutes < 10) {
        minutes = '0' + minutes;
    } else if (minutes > 60) {
        minutes -= 60;
        hours += 1;
    } else if (minutes == 60) {
        minutes = '00';
        hours += 1;
    }
    return currentTime.getUTCFullYear() + '-' + ('0' + (currentTime.getUTCMonth() + 1)).slice(-2) + '-' +
        ('0' + currentTime.getUTCDate()).slice(-2) + 'T' +
        ('0' + (hours)).slice(-2) + ':' + minutes + ':00.000Z';
}

/*
 * Adds specified amount of hours to the currentTime
 * @param currentTime Current timestamp
 * @param hours Amount of hours
 * @returns aggregated value (timestamp)
 */
const sumHours = (currentTime, hours) => {
    currentTime = new Date(currentTime);
    let minutes = currentTime.getMinutes();
    if (minutes < 10) {
        minutes = '0' + minutes;
    }
    return currentTime.getFullYear() + '-' + ('0' + (currentTime.getMonth() + 1)).slice(-2) + '-'
        + ('0' + currentTime.getDate()).slice(-2) + 'T' +
        ('0' + (currentTime.getHours() + hours)).slice(-2) + ':' + minutes + ':00.000Z';
}

/*
 * Validates date
 * @param date Date to validate
 * @returns True if Date is valid, False if Date is invalid
 */
const validateDate = (date) => {
    date = new Date(date);
    const year = date.getFullYear();
    const month = date.getMonth();
    const day = date.getDay();
    date = `${year}-${month}-${day}`;
    return date || date != null;
}


export { getNowUTC, sumMinutes, sumHours, validateDate };