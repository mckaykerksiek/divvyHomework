import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import ChartView from './ChartView.js';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business

  getChartValues() {
    var arr = []
    let rev = this.business.revenue.sort(function(a, b){
      if (a.date > b.date)
              return 1;
      if (a.date < b.date)
          return -1;
      return 0;});
    var highDate = 0

    for (let i = 0; i < rev.length; i++) {
      let str = rev[i].date
      let dateStr = str.replace(/\-/g,'/') 
      let date = new Date(dateStr)
      var month = date.getMonth()
      if (month > highDate) {
        highDate = month
      }
      if (month < highDate ) {
        month += 12
      }
      let val = {
        x: month,
        y: rev[i].value,
      }
      console.log(val)
      arr.push(val)
    }
    console.log(arr)
    return arr
  }
 
  render() {


    return (
      <View style={styles.container}>
        <View style={styles.infoContainer}>
          <Text style={styles.title}> { this.business.name } </Text>
          <Text style={styles.location}> { this.business.location.address} {this.business.location.city}, {this.business.location.country}</Text>
        </View>
        <Text style={styles.subtitle}> Last 6 months' revenue: </Text>
        <ChartView style={styles.chart} values={this.getChartValues()}/> 
      </View>
    )
  }
  
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   padding: 8,
   backgroundColor: 'white'
  },
  infoContainer: {
    height: 100,
    paddingVertical: 20
  },
  title: {
    fontSize: 32
  },
  subtitle: {
    fontSize: 20
  },
  location: {
    paddingLeft: 2,
    fontSize: 12,
    color: 'grey'
  },
  listImage: {
    width: 50,
    height: 50,
    margin: 12
  },
  chart: {
    padding: 12,
    height: 300
  }
});


