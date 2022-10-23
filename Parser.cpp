#include <bits/stdc++.h>
#define ll long long
#define in(a, b) for (ll i = (a); i <= (b); i++)                // in using i

using namespace std;


string toBin(ll i, ll bits)
{
    string s = "";
    if(i<0) {
        i=pow(2,bits)+i;
    }
    while (i > 0)
    {
        if (i%2)
        {
            s += '1';
        }
        else
            s += '0';
        i/=2;
    }
    // cout<<s.length()<<' '<<bits<<'\n';
    while (s.length() < bits)
        s += '0';
    reverse(s.begin(),s.end());
    return s;
}


    ll stono(string s){
        bool neg=0;
        if(s[0]=='-') {
            neg=1;
            s=s.substr(1,s.length()-1);
        }
        ll n=s.length();
        ll ans=0;
        in(0,n-1){
            ans+=(s[n-1-i]-48)*pow(10,i);
        }
        if(neg) ans*=-1;
        return ans;
    }

string get3R(string r){
    ll RD,RS1,RS2;
    string s;
    ll fc=-1,sc=-1;
            in(0,r.length()-1){
                if(r[i]==','){
                    if(fc==-1) fc=i;
                    else {
                        sc=i;
                        break;
                    }
                }
            }
            RD=stono(r.substr(1,fc-1));
            RS1=stono(r.substr(fc+2,sc-fc-2));
            RS2=stono(r.substr(sc+2,r.length()-sc-2));
            s+=toBin(RD,5);
            s+=toBin(RS1,5);
            s+=toBin(RS2,5);
            //cout<<s;
            return s;
}




string get2R1I(string r){
    ll RD,RS1,IMM;
    string s;
    ll fc=-1,sc=-1;
            in(0,r.length()-1){
                if(r[i]==','){
                    if(fc==-1) fc=i;
                    else {
                        sc=i;
                        break;
                    }
                }
            }
            RD=stono(r.substr(1,fc-1));
            RS1=stono(r.substr(fc+2,sc-fc-2));
            IMM=stono(r.substr(sc+1,r.length()-sc-1));
            s+=toBin(RD,5);
            s+=toBin(RS1,5);
            s+=toBin(IMM,16);
            //cout<<IMM<<endl;
            return s;
}






int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);
    cout<<setprecision(30);

    










    
    
    cout<<"`include \"defines.v\" \n \nmodule instructionMem (rst, addr, instruction);\n    input rst;\n    input [`WORD_LEN-1:0] addr;\n    output [`WORD_LEN-1:0] instruction;\n \n    wire [$clog2(`INSTR_MEM_SIZE)-1:0] address = addr[$clog2(`INSTR_MEM_SIZE)-1:0];\n    reg [`MEM_CELL_SIZE-1:0] instMem [0:`INSTR_MEM_SIZE-1];\n \n    always @ (*) begin\n        if (rst) begin\n            // No nop added in between instructions since there is a hazard detection unit \n";    
    ll a;
    string s;
    ll count=-1;
    while(cin>>s){
        count++;
        string ans="",r;
        if(s=="NOP"){
            ans+=toBin(0,32);
        }
        else if(s=="ADD"){
            ans+=toBin(2,6);
            cin>>r;
            ans+=get3R(r);
            //cout<<get3R(r);
            ans+=toBin(0,11);
        }
        else if(s=="SUB"){
            ans+=toBin(1,6);
            cin>>r;
            ans+=get3R(r);
            ans+=toBin(0,11);
        }
        else if(s=="ADDI"){
            ans+=toBin(32,6);
            cin>>r;
            ans+=get2R1I(r);
        }
        else if(s=="SUBI"){
            ans+=toBin(33,6);
            cin>>r;
            ans+=get2R1I(r);
        }
        else if(s=="LD"){
            ans+=toBin(34,6);
            cin>>r;
            ans+=get2R1I(r);
        }
        else if(s=="ST"){
            ans+=toBin(35,6);
            cin>>r;
            ans+=get2R1I(r);
        }
        else if(s=="BEZ"){
            ans+=toBin(36,6);
            cin>>r;
            r="r0,"+r;
            ans+=get2R1I(r);
        }
        else if(s=="BNE"){
            ans+=toBin(37,6);
            cin>>r;
            ans+=get2R1I(r);
        }
        else if(s=="JMP"){
            ans+=toBin(38,6);
            cin>>r;
            r="r0,r0,"+r;
            ans+=get2R1I(r);
        }
        cout<<endl;
        cout<<"            instMem["<<count*4<<"] <= 8'b"<<ans.substr(0,8)<<";  //-- "<<s<<"  "<<r<<endl;
        cout<<"            instMem["<<count*4+1<<"] <= 8'b"<<ans.substr(8,8)<<";"<<endl;
        cout<<"            instMem["<<count*4+2<<"] <= 8'b"<<ans.substr(16,8)<<";"<<endl;
        cout<<"            instMem["<<count*4+3<<"] <= 8'b"<<ans.substr(24,8)<<";"<<endl;



    }


    cout<<"        end\n    end\n\n  assign instruction = {instMem[address], instMem[address + 1], instMem[address + 2], instMem[address + 3]};\nendmodule // insttructionMem";
    
         
    return 0;
}