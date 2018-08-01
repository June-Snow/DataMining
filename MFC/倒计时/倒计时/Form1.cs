using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Media;

namespace 倒计时
{
    public partial class frmMain : Form
    {
        public frmMain( int intPass,string lbl)
        {
            InitializeComponent();
            intTime = intPass;
            strLbl = lbl;
        }
        int intTime;
        string strLbl;
        private static SoundPlayer pp = new SoundPlayer();
        private void Form1_Load(object sender, EventArgs e)
        {

            timer3.Enabled = true;//设置计时器可用  
            timer3.Interval = 100;//设置计时器周期时间（100毫秒=0.1秒）  
            this.Opacity = 0;//设置窗体透明度初始为0  

            lblC.Text=strLbl;
           
        }
              int count = 0;
        private void timer1_Tick(object sender, EventArgs e)
        {
           
            count++;
            intTime = intTime - 1;
            int Fen=intTime/(60);
            int Miao = intTime % 60;
            lbl2.ForeColor = System.Drawing.Color.Red;
            lbl2.Text = Fen.ToString() + "分";
            lbl3.ForeColor = System.Drawing.Color.Red;
            lbl3.Text = Miao.ToString() + "秒";
            //lbl.Text = intTime.ToString ();
            if (count == 10)
            {
                this.WindowState = FormWindowState.Minimized;
                notifyIcon1.Visible = true;
            }
            if(intTime == 10)
            {
                this.WindowState = FormWindowState.Normal;
                notifyIcon1.Visible = false;
            }

            if (Fen == 0 & Miao == 10)
            {
                Sound();
            }
            if (Fen == 0 & Miao == 0)
            {
                string path = @".\Sound\066.wav";

                pp.SoundLocation = path;
                pp.Play();
            }
            if (Fen == 0 & Miao == 0)
            {
                timer1.Enabled = false;
                lbl2.Text = "时间";
                lbl3.Text = "结束";
                timer2.Enabled = false;
                lblC.ForeColor = System.Drawing.Color.White;
                
            }
               
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            int R, G, B;
            Random dd = new Random();
            R = dd.Next(255); G = dd.Next(255); B = dd.Next(255);
            lblC.ForeColor = System.Drawing.Color.FromArgb(R, G, B);
        }
        private Point myPoint;//定义坐标变量
        //鼠标在窗体内按下时
        private void frmMain_MouseDown(object sender, MouseEventArgs e)
        {
            myPoint = new Point(-e.X, -e.Y);//记录鼠标的X,Y值（相对窗体），并设为负数
        }

        private void frmMain_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                Point myPosition = Control.MousePosition;//桌面上的坐标位置（相对桌面）
                myPosition.Offset(myPoint.X, myPoint.Y);//平移，使两个坐标点重合
                this.DesktopLocation = myPosition;//设置窗体在桌面上的位置
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {
            timer1.Enabled = false; timer2.Enabled = false; timer3.Enabled = false; 
            timer4.Enabled = true;//设置计时器可用  
            timer4.Interval = 100;//设置计时器周期时间（100毫秒=0.1秒）
            this.Opacity = 1;//设置窗体透明度初始为0 
            frm2 myfrm2 = new frm2();
            myfrm2.Show();
           
        }
        public void Sound()
        {
            string path = @".\Sound\06.wav";

            pp.SoundLocation = path;
            pp.Play();
        }
        
        private void timer3_Tick(object sender, EventArgs e)
        {
            if (this.Opacity < 1)//如果透明度小于1(透明度是按0-1计算的)  
            {
                this.Opacity = this.Opacity + 0.1;//透明度每次加上0.1  
            }
            else//当完全不透明时  
            {
                timer3.Enabled = false;//计时器设为不可用  
            }

        }

        private void timer4_Tick(object sender, EventArgs e)
        {
            if (this.Opacity > 0)//如果透明度小于1(透明度是按0-1计算的)  
            {
                this.Opacity = this.Opacity - 0.1;
            }
            else//当完全不透明时  
            {
                timer4.Enabled = false;//计时器设为不可用  

                this.Dispose();
                this.Close();
            }
        }

        private void notifyIcon1_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (this.WindowState == FormWindowState.Minimized)
            {
                this.Show();
                this.ShowInTaskbar = true;
                this.WindowState = FormWindowState.Normal;
                notifyIcon1.Visible = false;
                count = 0;
            }
        }
    }
}
