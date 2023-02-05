---
title: 力扣第 331 场周赛
date: 2023-02-05 22:00:00
---
## [周赛 331](https://leetcode.cn/contest/weekly-contest-331/)
### [从数量最多的堆取走礼物](https://leetcode.cn/problems/take-gifts-from-the-richest-pile/)

#### 题解
每次选择最大值进行 sqrt 就可以了，最终结果求和

#### 代码
```cpp
class Solution {
public:
    long long pickGifts(vector<int>& gifts, int k) {
        while (k --) {
            int maxx = 0;
            int pos = -1;
            for (int i = 0; i < gifts.size(); i ++) {
                if (gifts[i] > maxx) {
                    maxx = gifts[i];
                    pos = i;
                }
            }
            if (pos != -1) {
                gifts[pos] = sqrt(maxx);
            }
        }
        long long res = 0;
        for (int i = 0; i < gifts.size(); i ++) {
            res += gifts[i];
        }
        return res;
    }
};
```

### [统计范围内的元音字符串数](https://leetcode.cn/problems/count-vowel-strings-in-ranges/)

#### 题解
判断每个字符串，求前缀和。
每次查询求区间和

#### 代码
```cpp
const int maxn = 1e5+55;
int ans[maxn];
class Solution {
public:
    bool is_yuan(char ch) {
        return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
    }
    vector<int> vowelStrings(vector<string>& words, vector<vector<int>>& queries) {
        memset(ans, 0, sizeof(ans));
        for (int i = 0; i < words.size(); i ++) {
            if (is_yuan(words[i][0]) && is_yuan(words[i][words[i].length()-1])) {
                ans[i] = 1;
            } else {
                ans[i] = 0;
            }
            if (i) {
                ans[i] += ans[i-1];
            }
        }
        
        vector<int> vec;
        for (int i = 0; i < queries.size(); i ++) {
            int l = queries[i][0];
            int r = queries[i][1];
            if (l) {
                vec.push_back(ans[r] - ans[l-1]);
            } else {
                vec.push_back(ans[r]);
            }
        }
        return vec;
    }
};
```

## [打家劫舍 IV](https://leetcode.cn/problems/house-robber-iv/)

#### 题解
二分最小窃取能力
每次根据二分值去判断是否满足当前的最大盗窃能力大于等于 k

#### 代码
```cpp
class Solution {
public:
    bool check(vector<int>& nums, int num, int k) {
        bool flag = false;
        int ans = 0;
        for (int i = 0; i < nums.size(); i ++) {
            if (!flag && nums[i] <= num) {
                ans ++;
                if (ans == k) {
                    return true;
                }
                flag = true;
            } else {
                flag = false;
            }
        }
        return false;
    }
    int minCapability(vector<int>& nums, int k) {
        int l = 0, r = 1000000000;
        while (l < r) {
            int mid = (l + r) >> 1;
            if (check(nums, mid, k)) {
                r = mid;
            } else {
                l = mid + 1;
            }
        }
        return r;
    }
};
```

## [重排水果](https://leetcode.cn/problems/rearranging-fruits/)

#### 题解
先判断满不满足条件，两个数组中每个数字的总和需要是2的倍数。

两个数组找出不同的内容进行交换。
交换可以分为两种
 - 拿最小值交换两次，记最小值*2
 - 两个数字直接交换，取最小值


#### 代码
```cpp
class Solution {
public:
    long long minCost(vector<int>& basket1, vector<int>& basket2) {
        map<int, int> mp;
        vector<int> vec;
        for (int i = 0; i < basket1.size(); i ++) {
            if (mp[basket1[i]] == 0) {
                vec.push_back(basket1[i]);
            }
            mp[basket1[i]] ++;
        }
        for (int i = 0; i < basket2.size(); i ++) {
            if (mp[basket2[i]] == 0) {
                vec.push_back(basket2[i]);
            }
            mp[basket2[i]] ++;
        }
        int minn = -1;
        for (int i = 0; i < vec.size(); i ++) {
            if (mp[vec[i]] % 2) {
                return -1;
            }
            if (minn == -1) {
                minn = vec[i];
            } else {
                minn = min(minn, vec[i]);
            }
            mp[vec[i]] /= 2;
        }
        
        for (int i = 0; i < basket1.size(); i ++) {
            mp[basket1[i]] --;
        }
        
        vector<int> a;
        for (int i = 0; i < vec.size(); i ++) {
            while (mp[vec[i]] < 0) {
                a.push_back(vec[i]);
                mp[vec[i]] ++;
            }
            while (mp[vec[i]] > 0) {
                a.push_back(vec[i]);
                mp[vec[i]] --;
            }
        }
        
        sort(a.begin(), a.end());
        long long ans = 0;
        for (int i = 0; i < a.size() / 2; i ++) {
            ans += min(minn * ((a[i] != minn) + 1), a[i]);
        }
        return ans;
    }
};
```
