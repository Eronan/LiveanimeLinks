--Crowning of the Emperor
function c511000007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000007.cost)
	e1:SetTarget(c511000007.target)
	e1:SetOperation(c511000007.operation)
	c:RegisterEffect(e1)
end
function c511000007.cfilter(c,ft,tp)
	return c:IsFaceup() and c:IsCode(511000005) and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5))
end
function c511000007.filter(c,e,tp)
	return c:IsCode(511000006) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c511000007.cfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511000007.cfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c511000007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511000007.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000007.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000007.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
