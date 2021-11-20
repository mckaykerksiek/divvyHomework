import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import ChartView from './ChartView.js';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business

  getChartValues() {
    arr = []
    rev = this.business.revenue
    for (let i = 0; i < rev.length; i++) {
      val = {
        x: i, //toDate(rev[i].date).getMonth(),
        y: rev[i].value,
      }
      arr.push(val)
    }

    // for (i in business.revenue) {
    
    return arr
  }

  render() {


    return (
      <View style={styles.container}>
        <View style={styles.container}>
          <Text style={styles.title}> { this.business.name } </Text>
          <Text style={styles.location}> { this.business.location.address}  {this.business.location.city}, {this.business.location.country}</Text>
        </View>
        <ChartView style={{ flex: 1 }} values={this.getChartValues()}/> 
        
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
  title: {
    fontSize: 32
  },
  location: {
    fontSize: 12,
    color: 'grey'
  },
  listImage: {
    width: 50,
    height: 50
  },
});


