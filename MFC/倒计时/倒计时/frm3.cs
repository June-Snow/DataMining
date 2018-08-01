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
    public partial class frm3 : Form
    {
        public frm3()
        {
            InitializeComponent();
        }

        private void frm3_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            frmMain myfrmMain = new frmMain(int.Parse(textBox1.Text.ToString().Trim()), "     " + textBox2.Text);
            myfrmMain.Show();
            this.Hide();
        }
        

    }

    }

