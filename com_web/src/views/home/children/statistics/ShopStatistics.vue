<template>
  <div>
    <!-- 导航 -->
    <mbx-nav one-nav="数据统计" two-nav="商城数据统计"></mbx-nav>
    <!-- 卡片试图 -->
    <el-card>
      <el-row :gutter="20">
          <el-col :span="8"><div class="grid-content bg-purple-1">今日销售额:{{info.todayMoney}}</div></el-col>
           <el-col :span="8"><div class="grid-content bg-purple-2">当月销售额:{{info.monthMoney}}</div></el-col>
          <el-col :span="8"><div class="grid-content bg-purple-3">本年销售额:{{info.yearMoney}}</div></el-col>
         
    </el-row>

    <el-row :gutter="250" class="chart-row">
          <el-col :span="8">
            <div class="chart-content">
              <div id="chart1" :style="{ width: '460px', height: '500px' }"></div>
            </div>
          </el-col>
          <el-col :span="16">
            <div class="chart-content">
              <div id="chart2" :style="{ width: '920px', height: '500px' }"></div>
            </div>
          </el-col>
        
          
         
    </el-row>

    </el-card>
  
  </div>
</template>

<script>
import mbxNav from 'components/MbxNav'
import { 
  getShopTj,
 
  } from 'network/user'

export default {
  name: 'Statistics',
  components: {
    mbxNav
  },
  data(){
 
    return {
    
      info: {
       
      },
	 
    }
  },
  created(){
    this.getTj()
	
  },
  mounted() {
   
  },
  methods: {
    /**
     * 获取、更新用户数据
     */
	//   获取所有的商品分类列表
	getTj () {
	  getShopTj().then(res => {
	    // console.log(res)
	    if (res.data.code !== 200) {
	      return this.$message.error('获取数据列表失败！')
	    }
	    this.info = res.data.data

      this.drawPie("chart1");
      this.drawLine("chart2");
	  })
	},
  
  drawLine(name) {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(document.getElementById(name));
      let datex=[],hyd=[],xzs=[];
      this.info.hotGoodsList.forEach(function(item, index) {
        datex[index]=item.name
        hyd[index]=item.num
        xzs[index]=item.money 
      })
   let  option = {
        title: {
          text: '今日商品销售分析'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['数量', '销售额']
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: datex
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '数量',
            type: 'line',
            stack: 'Total',
            data: hyd
          },
          {
            name: '销售额',
            type: 'line',
            stack: 'Total',
            data: xzs
          }
        ]
      };
           myChart.setOption(option);
      },

          drawPie(name) {
            // 基于准备好的dom，初始化echarts实例
            let myChart = this.$echarts.init(document.getElementById(name));
            let datex=[],hyd=[];
            this.info.sevenTjs.forEach(function(item, index) {
            datex[index]=item.day
            hyd[index]=item.todayMoney
               
              })
            let  option = {
              title: {
                text: '近七日销售额'
                },
                  xAxis: {
                    type: 'category',
                    data: datex
                  },
                  yAxis: {
                    type: 'value'
                  },
                  series: [
                    {
                      data: hyd,
                      type: 'bar'
                    }
                  ]
                };
           
          myChart.setOption(option);
    },
 
  }
}
</script>

<style lang="less" scoped>
  .el-row {
    margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  .el-col {
    border-radius: 4px;
  }
 
  .bg-purple-1 {
    background: #67C23A;
  }
  
  .bg-purple-2{
    background: #E6A23C;
  }
  
  .bg-purple-3 {
    background: #F56C6C;
  }
  
  .bg-purple-4{
    background: #909399;
  }
  .grid-content {
    border-radius: 4px;
    height: 200px;
    line-height: 200px;
    text-align: center;
    font-size: 35px;
    color: #fff;
  }
  .chart-row{
    margin-bottom: 100px;
    margin-top: 100px;
  }
  .chart-content{
    border-radius: 4px;
   
   
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
</style>