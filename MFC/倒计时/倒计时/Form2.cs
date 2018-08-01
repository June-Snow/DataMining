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
    public partial class frm2 : Form
    {
        public frm2()
        {
            InitializeComponent();
        }

        private static SoundPlayer player = new SoundPlayer();

        private void label1_Click(object sender, EventArgs e)
        {
            frmMain myfrmMain = new frmMain(121, label1.Text);//121
            myfrmMain.Show();
            this.Hide();

        }

        private void label2_Click(object sender, EventArgs e)
        {
            frmMain myfrmMain = new frmMain(301," "+ label2.Text);
            myfrmMain.Show();
            this.Hide();
        }

        private void label3_Click(object sender, EventArgs e)
        {
            frmMain myfrmMain = new frmMain(181,"  "+ label3.Text);
            myfrmMain.Show();
            this.Hide();
        }

        private void label4_Click(object sender, EventArgs e)
        {
            
            this.Dispose();
            Application.Exit();
            //this.Close();
        }

        private void label1_MouseEnter(object sender, EventArgs e)
        {
            Sound();
            label1.ForeColor = System.Drawing.Color.Blue;
        }

        private void label1_MouseLeave(object sender, EventArgs e)
        {
            label1.ForeColor = System.Drawing.Color.Black;
        }

        private void label2_MouseEnter(object sender, EventArgs e)
        {
            Sound();
            label2.ForeColor = System.Drawing.Color.Red;
        }

        private void label2_MouseLeave(object sender, EventArgs e)
        {
            label2.ForeColor = System.Drawing.Color.Black;
        }

        private void label3_MouseEnter(object sender, EventArgs e)
        {
            Sound();
            label3.ForeColor = System.Drawing.Color.Yellow;
        }

        private void label3_MouseLeave(object sender, EventArgs e)
        {
            label3.ForeColor = System.Drawing.Color.Black;
        }
        private Point myPoint;//定义坐标变量
        //鼠标在窗体内按下时
        private void Form2_MouseDown(object sender, MouseEventArgs e)
        {
            myPoint = new Point(-e.X,-e.Y);//记录鼠标的X,Y值（相对窗体），并设为负数
        }
        //鼠标移动事件
        private void Form2_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                Point myPosition = Control.MousePosition;//桌面上的坐标位置（相对桌面）
                myPosition.Offset(myPoint.X,myPoint.Y);//平移，使两个坐标点重合
                this.DesktopLocation = myPosition;//设置窗体在桌面上的位置
            }
        }

        private void label4_MouseEnter(object sender, EventArgs e)
        {
            label4.ForeColor = System.Drawing.Color.White;
        }

        private void label4_MouseLeave(object sender, EventArgs e)
        {
            label4.ForeColor = System.Drawing.Color.Black;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //this.Size = new Size(this.Width * 3, this.Height*3); 
            ////this.Width = 1000;
            //this.Height = 5010;
        }

        private void Form2_Resize(object sender, EventArgs e)
        {
            //this.Width = (this.Width) * 3;
            //this.Height = (this.Height) * 3;
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }
        public void Sound()
        {
            //string path = @"C:\Users\Administrator\Desktop\pic375_各种音效打包\各类音效\器械\钢琴\07.wav";
            string path = @".\Sound\03.wav";

            player.SoundLocation = path;
            player.Play();
        }

        private void 设置时间ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frm3 myfrm3 = new frm3();
            myfrm3.Show();
        }
    }
}
